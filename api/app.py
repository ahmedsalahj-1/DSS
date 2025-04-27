from flask import Flask, request, jsonify
import xgboost as xgb
import joblib
import numpy as np
import pandas as pd
import os

app = Flask(__name__)

# Get the model storage path
MODEL_STORAGE = os.getenv('MODEL_STORAGE', '/opt/render/model-storage')

# Load the model and scaler
model = xgb.XGBClassifier()
model.load_model(os.path.join(MODEL_STORAGE, 'crop_recommendation_model.json'))
scaler = joblib.load(os.path.join(MODEL_STORAGE, 'scaler.joblib'))

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get data from request
        data = request.get_json()
        
        # Extract features
        features = [
            float(data['N']),
            float(data['P']),
            float(data['K']),
            float(data['temperature']),
            float(data['humidity']),
            float(data['ph']),
            float(data['rainfall'])
        ]
        
        # Convert to numpy array and reshape
        features = np.array(features).reshape(1, -1)
        
        # Scale features
        features_scaled = scaler.transform(features)
        
        # Make prediction
        prediction = model.predict(features_scaled)
        probability = model.predict_proba(features_scaled)
        
        # Get the top 3 predictions with their probabilities
        top_3_idx = np.argsort(probability[0])[-3:][::-1]
        top_3_predictions = []
        
        for idx in top_3_idx:
            top_3_predictions.append({
                'crop': model.classes_[idx],
                'probability': float(probability[0][idx])
            })
        
        return jsonify({
            'status': 'success',
            'predictions': top_3_predictions
        })
        
    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=10000) 